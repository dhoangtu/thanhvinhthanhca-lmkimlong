% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Dâng Lời Ngợi Khen" }
  composer = "Tv. 112"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4. c8 d e |
  f4 f ~ |
  f8 e d d |
  g4 r8 c |
  b b c8. d16 |
  c8 g r g |
  e'8. f16 e8 c ~ |
  c4 r8 c |
  b8. b16 d8 c |
  g2 ~ |
  g8 c, d e |
  f4 f ~ |
  f8 e d d |
  g4 r8 g |
  fs fs g8. a16 |
  g8 e r e |
  a8. b16 a8 g ~ |
  g4 r8 g16 g |
  d'8. e16 d8 b |
  c2 ~ |
  c8 \bar "||" \break
  
  c, f e |
  d8. g16 a8 fs |
  g4. c16 c |
  a8 g \once \stemUp c
  <<
    {
      \voiceOne
      b
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.5
      \tweak font-size #-2
      \parenthesize
      c
    }
  >>
  \oneVoice
  \slashedGrace { b16 (c } d2) ~ |
  d8 d d e |
  e,8. e16 a8 a |
  g4 \tuplet 3/2 { g8 c b } |
  a a16 a d8 e |
  c2 ~ |
  c8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c8 d e |
  f4 f ~ |
  f8 e d d |
  g4 r8 e |
  g g a8. g16 |
  e8 e r g |
  c8. a16 g8 e ~ |
  e4 r8 a |
  g8. g16 fs8 fs |
  g2 ~ |
  g8 c, d e |
  f4 f ~ |
  f8 e d d |
  g4 r8 e |
  d d e8. c16 |
  b8 c r c |
  f8. g16 f8 e ~ |
  e4 r8 e16 e |
  f8. g16 f8 d |
  e2 ~ |
  e8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Nào tôi tớ Chúa,
  hãy dâng lời ngợi khen,
  Dâng lời ngợi khen thánh danh Ngài,
  ngợi khen thanh danh Ngài,
  bây giờ và đến muôn đời.
  Nào tôi tớ Chúa,
  hãy dâng lời ngợi khen,
  dâng lời ngợi khen thánh danh Ngài,
  ngợi khen thánh danh Ngài,
  từ bình minh tới khi hoàng hôn.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Vì Chúa siêu việt trên hết mọi dân,
      Vinh quang Ngài vượt trên trời thẳm
      Ai đâu sánh tầy Thượng Đế, Chúa ta,
      Từ chốn cao vời Ngài nhìn xem đất trời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài nhắc kẻ hèn nơi cát bụi lên,
	    Nâng dân nghèo từ trong
	    \markup { \italic \underline "phân" }
	    thổ
	    Lên ngang với hàng quyền quý phúc vinh
	    Và khiến cho người muộn mằn nên mẫu hiền.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}

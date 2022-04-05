% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Là Phần Gia Nghiệp" }
  composer = "Tv. 15"
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
      (padding . 0.4)
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
  \partial 8
  \once \override NoteColumn.X-offset = 1 <>
  c8 |
  g'4 \tuplet 3/2 { g8 af f } |
  g4. ef8 |
  f8. f16 \tuplet 3/2 { g8 ef d } |
  c2 \bar "|." \break
  
  g'8 g e (g) |
  a4. g8 |
  a c e c |
  d4 b8 d |
  c4. c8 |
  g4 gs |
  a2 |
  a8 fs fs g |
  e4. d8 |
  g2 ~ |
  g8 g e' e |
  a,4. b8 |
  c2 ~ |
  c4 \bar "||" \break
  
  g8 g |
  a2 ~ |
  a8
  <<
    {
      \voiceOne
      a
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \tweak font-size #-2
      \parenthesize
      d,
    }
  >>
  \oneVoice
  e c' |
  c4 r8 b16 b |
  c8 d e4 ~ |
  e8 \slashedGrace { c8 ( } b4) a8 |
  b2 |
  g!?4. g16 e |
  c'8 c b e |
  a,2 ~ |
  a4 r \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*4
  b8 b c (e) |
  f4. e8 |
  f a c a |
  g4 d8 f |
  e4. f8 |
  e4 e |
  c2 c8 d d b |
  c4. c8 |
  b
  \once \override NoteColumn.X-offset = 1.5 b
  a b |
  c [e] g g |
  f4. d8 |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "Mở đầu:"
  \tweak extra-offset #'(0.6 . 0)
  Lạy Chúa, xin giữ gìn con vì con nương náu ở nơi Ngài.
  \set stanza = "ĐK:"
  Con thưa cùng Chúa:
  Ngài là Thiên Chúa của con,
  Ngoài Chúa ra đâu là hạnh phúc.
  Chúa là phần gia nghiệp đời con
  là chén phúc lộc của con.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Vận mạng con tay Ngài nắm giữ,
      phần tuyệt hảo may mắn đã về con.
      Vâng gia nghiệp ấy khiến con mãn nguyện.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lòng dạ con ca tụng Chúa mãi,
	    vì ngài đà thương mến chỉ dạy con.
	    Đây con hằng nhớ Chúa ở trước mặt.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngài ở bên đâu còn khiếp hãi,
	    và này cả thân xác cũng nghỉ ngơi.
	    Ôi bao mừng rỡ hỉ hoan cõi lòng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài dạy con
	    \markup { \italic \underline "đường" }
	    về cõi sống,
	    và được ở bên Chúa phúc lộc thay,
	    Con vui mừng mãi trước nhan thánh Ngài.
    }
  >>
}

loiPhienKhucAlto = \lyrics {
  \repeat unfold 24 { _ }
  \override Lyrics.LyricText.font-shape = #'italic
  gia nghiệp đời con
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
      \new NullVoice = beAlto \nhacPhienKhucAlto
      \new Lyrics \lyricsto beAlto \loiPhienKhucAlto
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}

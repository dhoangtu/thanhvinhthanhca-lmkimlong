% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Cho Đến Bao Giờ" }
  composer = "Tv. 12"
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
nhacPhienKhucSop = \relative c'' {
  \partial 4 \tuplet 3/2 { g8 af g } |
  c,4. c8 |
  g'4 \tuplet 3/2 { ef8 af g } |
  f4 \tuplet 3/2 { f8 g f } |
  d4. d8 |
  \slashedGrace { f8 ( } g4) \tuplet 3/2 { ef8 g, bf } |
  c4 r8 \bar "||" \break
  
  ef16 ef |
  ef4. d8 |
  c8. ef16 ef8 f |
  g4 \tuplet 3/2 { bf8 [c ef] } |
  d4. af8 |
  af4 c8 af |
  g2 ~ |
  g4 r8 ef16 ef |
  ef4. d8 |
  c8. ef16 ef8 f |
  g4 \tuplet 3/2 { bf8 c ef } |
  d4. af8 |
  af4 bf8 g |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*5
  r4.
  c16 c |
  c4. bf8 |
  c8. c16 c8 d |
  ef4 \tuplet 3/2 { d8 [ef c] } |
  g'4. g8 |
  f4 ef8 c |
  bf2 ~ |
  bf4 r8 c16 c |
  c4. bf8 |
  c8. c16 c8 c |
  ef4 \tuplet 3/2 { d8 [ef c] } |
  g'4. g8 |
  fs4 g8 f! |
  ef2 ~ |
  ef4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Cho đến bao giờ, lạy Chúa,
      Ngài cứ quên con,
      cho đến bao giờ Ngài vẫn ngoảnh mặt làm ngơ,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Cho đến bao giờ,
	    hồn những sợ hãi lo toan,
	    cho đến bao giờ lòng vẫn khổ sầu ngày đêm?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cho đến bao giờ, Ngài mới nhận tiếng con van
	    cho đến bao giờ cặp mắt sẽ được rạng soi?
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Nhưng con luôn tin cậy vào tình thương Chúa,
  Lòng con
  <<
  { sướng }
  \new Lyrics {
	  \set associatedVoice = "beBas"
	  \override Lyrics.LyricText.font-shape = #'italic
	  mừng
	}
  >>
  vui trong ơn Chúa cứu độ.
  Xin ca lên muôn lời  phụng mừng danh Chúa
  vì muôn
  <<
  { phúc }
  \new Lyrics {
	  \set associatedVoice = "beBas"
	  \override Lyrics.LyricText.font-shape = #'italic
	  hồng
	}
  >>
  ân cao sang Chúa rộng ban.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key ef \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}

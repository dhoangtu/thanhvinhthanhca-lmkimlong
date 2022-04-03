% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vua Vinh Hiển" }
  composer = "Tv. 23"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  %<> \tweak extra-offset #'(-6.5 . -2.5) _\markup { \bold "ĐK:" }
  \partial 8 c8 |
  \repeat volta 2 {
    e8. f16 e8 e |
    g2 |
    c8. b16 a8 a |
    r8 c16 c b8 c |
    d d16 d c8 d |
    e4. c8 |
    d d a16 (c) a8 |
    g2 ~ |
    g4 g8 g |
    f8. d16 d8 g |
    c,4 r8 g' |
    e'8. e16 c8 d |
    d4 r8 d
  }
  \alternative {
    {
      c8. c16 b8 c |
      d g, ~ g4 ~ |
      g r8 c,
    }
    {
      g'8. g16 d'8 c |
      b [c] ~ c4 ~ |
      c4 r8 \bar "||" \break
    }
  }
  
  c8 |
  c c16 g f8 g |
  e4 r8 d |
  d d16 a' fs8 g |
  g a4 ^> b8 |
  c b4 ^> c8 |
  d4 r8 c |
  c c16 e d8 b |
  c4 r8 a |
  b b16 c b8 a |
  g a4 ^> f8 |
  e f4 ^> d8 |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c8 |
  e8. f16 e8 e |
  g2 |
  e8. g16 f8 f |
  r e16 e d8 e |
  g8 g16 g e8 g |
  c4. a8 |
  g g fs [fs] |
  g2 ~ |
  g4 g8 g |
  f8. d16 d8 g |
  c,4 r8 g' |
  c8. c16 a8 a |
  g4 r8 f |
  e8. e16 g8 a |
  f e ~ e4 ~ |
  e r8 c |
  e8. e16 d8 f |
  g <e c> ~ <e c>4 ~ |
  <e c>4 r8
  
  c'8 |
  c c16 g f8 g |
  e4 r8 d |
  d d16 a' fs8 g |
  g fs4 g8 |
  a g4 ^> a8 |
  b4 r8 c |
  c c16 e d8 b |
  c4 r8 a |
  b b16 c b8 a |
  g f4 d8 |
  c d4 ^> b8 |
  c4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Cửa ơi, hãy ngẩng đầu lên,
  hỡi cửa ngàn đời,
  Mau vươn mình lên nữa,
  mau vươn mình lên nữa
  để Vua vinh hiển ngự vào.
  Vua vinh hiển Người là ai vậy?
  
  <<
    {
      Là Chúa lẫm liệt oai phong,
      Đức
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Thượng Đế lãnh đạo thiên binh, chính
	  }
  >>
  Vua uy hùng khi xuất trận,
  Cửa...
  Người là Đức Vua hiển vinh.
  <<
    {
      \set stanza = "1."
      Trái đất với muôn vật muôn loài,
      Hoàn cầu cùng tất cả cư dân là của Chúa,
      là của Chúa,
      Ngài đặt nền đất trên biển khơi,
      làm cho kiên vững không chuyển rời giữa sông ngòi,
      giữa sông ngòi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Núi thánh Chúa, ai người lên được?
	    Đền vàng Ngài, kẻ nào nương thân thực vinh phúc,
	    thực vinh phúc,
	    là người hằng giữ tay sạch tinh,
	    miệng không gian dối nên luôn được Chúa thương tình,
	    Chúa thương tình.
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
     (padding . 0.5)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}

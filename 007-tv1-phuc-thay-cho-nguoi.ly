% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Phúc Thay Cho Người" }
  composer = "Tv. 1"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 c8 |
  a g d4 |
  f8. f16 e8 f |
  a g4 a8 |
  b8. b16 g8 c |
  b16 (c) d4 d16 c |
  c8 e e, f |
  g4 r8 \bar "||"
  
  e16 e |
  f8 f d d |
  g4. g8 |
  g8. a16 f8 e |
  d4 r8 c |
  g'8. g16 e8 g |
  a4. b8 |
  g c b16 (c) e8 |
  d4 r8 d |
  b8 c16 c a8 a |
  g4. f8 |
  d8. d16 g8 g |
  c,2 ~ |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  \skip 8
  \repeat unfold 6 { \skip 2 }
  \skip 4.
  c16 c |
  d8 d c c |
  b4. b8 |
  c8. f16 d8 c |
  b4 r8 c |
  b8. b16 c8 e |
  f4. f8 |
  e a g16 (a) c8 |
  g4 r8 fs |
  g a16 g fs8 f! |
  e4. d8 |
  c8. c16 b8 b |
  c2 ~ |
  c4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Phúc thay cho người
      không theo lời bọn ác nhân,
      không tiến bước cùng quân tội lỗi,
      không nhập bọn với phường kiêu căng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Những quân tham tàn lao xao tựa vỏ trấu bay,
	    đâu đứng vững được khi xử án,
	    đâu hợp đoàn với người thiện tâm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "3."
	    Chúa luôn thương tình trông coi
	    đường nẻo chính nhân,
	    khi những lối đường quân tội lỗi
	    luôn đẩy vào chốn bị diệt vong.
    }
  >>
  \set stanza = "ĐK:"
  Ai vui thú theo lề luật Chúa,
  suy đi gẫm lại đêm ngày,
  Họ như cây trồng bên suối,
  đúng mùa hoa quả trổ sinh,
  lá cành không khi nào tàn tạ,
  Họ làm gì cũng sẽ thành.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

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

                     (ly:pointer-group-interface::add-grob text 'side-support-elements syllable))

                   syllables))
                texts)
               (set! syllables '())))))
  }
  \context {
    \Lyrics
    \remove Stanza_number_engraver
    \consists
      #(lambda (context)
         (let ((text #f))
           (make-engraver
            ((process-music engraver)
               (if (not text)
                   (let ((stanza (ly:context-property context 'stanza #f)))
                     (if stanza
                         (begin

                           (set! text (ly:engraver-make-grob engraver 'StanzaNumberSpanner '()))                            (let ((column (ly:context-property context 'currentCommandColumn)))

                             (ly:grob-set-property! text 'text stanza)
                             (ly:spanner-set-bound! text LEFT column)))))))
            ((finalize engraver)
               (if text

                   (let ((column (ly:context-property context 'currentCommandColumn)))

                     (ly:spanner-set-bound! text RIGHT column)))))))
    \override StanzaNumberSpanner.horizon-padding = 10000
    \override LyricText.font-shape = #'italic
  }
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  }
}
